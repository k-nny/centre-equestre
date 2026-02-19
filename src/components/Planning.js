import React, { useEffect, useState } from 'react'
import { supabase } from '../supabaseClient'

export default function Planning({ equides, cavaliers, moniteurs }) {
    const [cours, setCours] = useState([])
    const [affectations, setAffectations] = useState([])

    useEffect(() => {
        fetchCours()
        fetchAffectations()
    }, [])

    async function fetchCours() {
        const { data, error } = await supabase.from('cours_instances').select('*')
        if (!error) setCours(data)
    }

    async function fetchAffectations() {
        const { data, error } = await supabase.from('affectations').select('*')
        if (!error) setAffectations(data)
    }

    return (
        <div>
            {cours.length === 0 && <p>Chargement des cours...</p>}
            {cours.map(c => (
                <div key={c.id}>
                    <strong>{c.date} - {c.heure} - {c.type_cours}</strong>
                    <ul>
                        {(affectations || []).filter(a => a.cours_instance_id === c.id).map(a => {
                            const cavalier = cavaliers.find(cav => cav.id === a.cavalier_id)
                            const cheval = equides.find(eq => eq.id === a.equide_id)
                            return <li key={a.id}>{cavalier?.prenom || "?"} → {cheval?.nom || "?"}</li>
                        })}
                    </ul>
                </div>
            ))}
        </div>
    )
}